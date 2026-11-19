// SPDX-License-Identifier: GPL-2.0-or-later
using System.Globalization;
using System.Text;

namespace Cxadc_ControlPanel.Services;

/// <summary>
/// Appends diagnostic lines to %USERPROFILE%\cxcc_logs so users can attach them to bug reports.
/// Logging never throws: a failure to write must not take the panel down.
/// </summary>
public static class AppLog
{
    private const int RetentionDays = 30;
    private static readonly object Gate = new();
    private static bool _initialized;
    private static string _filePath = "";

    public static string DirectoryPath { get; } = Path.Combine(
        Environment.GetFolderPath(Environment.SpecialFolder.UserProfile),
        "cxcc_logs");

    public static string FilePath => _filePath;

    public static void Initialize()
    {
        if (_initialized)
            return;
        _initialized = true;
        try
        {
            Directory.CreateDirectory(DirectoryPath);
            _filePath = Path.Combine(
                DirectoryPath,
                $"cxadc-control-panel-{DateTime.Now.ToString("yyyyMMdd", CultureInfo.InvariantCulture)}.log");
            PruneOldFiles();
            var version = typeof(AppLog).Assembly.GetName().Version?.ToString() ?? "unknown";
            Info($"Panel starting: version {version}, {Environment.OSVersion}, " +
                 $"{System.Runtime.InteropServices.RuntimeInformation.OSArchitecture}, " +
                 $"runtime {Environment.Version}, user {Environment.UserName}");
            Info($"Settings file: {SettingsStore.SettingsPath}");
        }
        catch
        {
            // Logging is best effort.
        }
    }

    public static void Info(string message) => Write("INFO", message, null);

    public static void Warn(string message, Exception? exception = null) => Write("WARN", message, exception);

    public static void Error(string message, Exception? exception = null) => Write("ERROR", message, exception);

    private static void Write(string level, string message, Exception? exception)
    {
        try
        {
            var builder = new StringBuilder()
                .Append(DateTimeOffset.Now.ToString("yyyy-MM-dd HH:mm:ss.fff zzz", CultureInfo.InvariantCulture))
                .Append(" [").Append(level).Append("] ")
                .Append(message);
            if (exception is not null)
            {
                builder.AppendLine()
                    .Append("    ").Append(exception.GetType().FullName).Append(": ").Append(exception.Message);
                if (!string.IsNullOrWhiteSpace(exception.StackTrace))
                    builder.AppendLine().Append(exception.StackTrace);
                if (exception.InnerException is not null)
                    builder.AppendLine().Append("    inner: ").Append(exception.InnerException.GetType().FullName)
                        .Append(": ").Append(exception.InnerException.Message);
            }

            lock (Gate)
            {
                if (_filePath.Length == 0)
                {
                    Directory.CreateDirectory(DirectoryPath);
                    _filePath = Path.Combine(
                        DirectoryPath,
                        $"cxadc-control-panel-{DateTime.Now.ToString("yyyyMMdd", CultureInfo.InvariantCulture)}.log");
                }
                File.AppendAllText(_filePath, builder.AppendLine().ToString(), Encoding.UTF8);
            }
        }
        catch
        {
            // Logging is best effort.
        }
    }

    private static void PruneOldFiles()
    {
        var cutoff = DateTime.Now.AddDays(-RetentionDays);
        foreach (var file in Directory.EnumerateFiles(DirectoryPath, "cxadc-control-panel-*.log"))
        {
            try
            {
                if (File.GetLastWriteTime(file) < cutoff)
                    File.Delete(file);
            }
            catch
            {
                // A file in use can be skipped.
            }
        }
    }
}
