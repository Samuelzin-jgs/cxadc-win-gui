// SPDX-License-Identifier: GPL-2.0-or-later
using System.Globalization;
using System.Xml.Linq;

namespace Cxadc_ControlPanel.Services;

public static class LanguageSettings
{
    public static string CurrentLanguage { get; private set; } = "";
    private static IReadOnlyDictionary<string, string> _resources = new Dictionary<string, string>();

    public static bool HasSavedLanguage { get; private set; }

    public static void Initialize()
    {
        var saved = ReadSavedLanguage();
        HasSavedLanguage = saved is "pt-BR" or "en-US";
        CurrentLanguage = ResolveLanguage(saved);
        _resources = LoadResources(CurrentLanguage);
    }

    public static void SetLanguage(string language)
    {
        if (language is not ("pt-BR" or "en-US"))
            throw new ArgumentOutOfRangeException(nameof(language));

        CurrentLanguage = language;
        _resources = LoadResources(language);
        HasSavedLanguage = true;
        var settings = SettingsStore.Load();
        settings.Language = language;
        SettingsStore.Save(settings);
    }

    public static string Get(string key)
    {
        return _resources.TryGetValue(key, out var value) && !string.IsNullOrWhiteSpace(value)
            ? value
            : key;
    }

    private static IReadOnlyDictionary<string, string> LoadResources(string language)
    {
        var path = Path.Combine(AppContext.BaseDirectory, "Strings", language, "Resources.resw");
        if (!File.Exists(path))
            return new Dictionary<string, string>();

        return XDocument.Load(path)
            .Descendants("data")
            .Where(element => element.Attribute("name") is not null)
            .ToDictionary(
                element => element.Attribute("name")!.Value,
                element => element.Element("value")?.Value ?? "",
                StringComparer.Ordinal);
    }

    private static string ResolveLanguage(string savedLanguage)
    {
        if (savedLanguage is "pt-BR" or "en-US")
            return savedLanguage;
        return CultureInfo.CurrentUICulture.TwoLetterISOLanguageName.Equals("pt", StringComparison.OrdinalIgnoreCase)
            ? "pt-BR"
            : "en-US";
    }

    private static string ReadSavedLanguage() => SettingsStore.Load().Language ?? "";
}
