// SPDX-License-Identifier: GPL-2.0-or-later
using System.Text.Json;

namespace Cxadc_ControlPanel.Services;

public sealed class CardPreset
{
    public string Name { get; set; } = "";
    public int VideoMux { get; set; }
    public int Level { get; set; }
    public int CenterOffset { get; set; }
    public bool TenBit { get; set; }
    public bool SixDb { get; set; }
    public string? Clock0 { get; set; }
    public string? Clock1 { get; set; }
    public string? AdcRate { get; set; }
}

public sealed class AppSettings
{
    public string? Language { get; set; }
    public List<CardPreset> Presets { get; set; } = new();
}

public static class SettingsStore
{
    public static string SettingsPath { get; } = Path.Combine(
        Environment.GetFolderPath(Environment.SpecialFolder.LocalApplicationData),
        "CXADC Tools",
        "settings.json");

    private static readonly JsonSerializerOptions Options = new() { WriteIndented = true };

    public static AppSettings Load()
    {
        try
        {
            return JsonSerializer.Deserialize<AppSettings>(File.ReadAllText(SettingsPath)) ?? new AppSettings();
        }
        catch
        {
            return new AppSettings();
        }
    }

    public static void Save(AppSettings settings)
    {
        Directory.CreateDirectory(Path.GetDirectoryName(SettingsPath)!);
        File.WriteAllText(SettingsPath, JsonSerializer.Serialize(settings, Options));
    }

    public static void SavePreset(CardPreset preset)
    {
        var settings = Load();
        settings.Presets.RemoveAll(p => string.Equals(p.Name, preset.Name, StringComparison.OrdinalIgnoreCase));
        settings.Presets.Add(preset);
        settings.Presets.Sort((a, b) => string.Compare(a.Name, b.Name, StringComparison.CurrentCultureIgnoreCase));
        Save(settings);
    }

    public static void DeletePreset(string name)
    {
        var settings = Load();
        settings.Presets.RemoveAll(p => string.Equals(p.Name, name, StringComparison.OrdinalIgnoreCase));
        Save(settings);
    }
}
