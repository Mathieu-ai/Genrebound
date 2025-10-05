// https://nuxt.com/docs/api/configuration/nuxt-config
export default defineNuxtConfig({
    compatibilityDate: '2025-07-15',
    devtools: { enabled: true },

    modules: [
        '@nuxt/eslint',
        '@nuxt/image',
        '@nuxt/scripts',
        '@nuxt/test-utils',
        '@nuxt/ui',
        '@pinia/nuxt',
        '@prisma/nuxt',
        '@nuxtjs/i18n'
    ],
    css: ['~/assets/css/main.css'],

    i18n: {
        defaultLocale: "en",
        detectBrowserLanguage: {
            useCookie: true,
            cookieKey: "i18n_redirected",
            alwaysRedirect: true,
            fallbackLocale: "en"
        },
        strategy: "no_prefix",
        langDir: "locales",
        locales: [
            { code: "en", name: "English", flag: "🇬🇧", file: "en.json" },
            { code: "fr", name: "Français", flag: "🇫🇷", file: "fr.json" }
        ],
    },
    runtimeConfig: {
        public: {
            i18n: {
                locales: [
                    { code: "en", name: "English", flag: "🇬🇧" },
                    { code: "fr", name: "Français", flag: "🇫🇷" }
                ]
            }
        }
    },
})