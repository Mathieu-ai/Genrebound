import { defineStore } from 'pinia'
import { ref, computed } from 'vue'
import { useColorMode } from '@vueuse/core'
import { useAppConfig, useRuntimeConfig, useI18n } from '#imports'
import type { DropdownMenuItem } from '@nuxt/ui'

export const useUserMenuStore = defineStore('userMenu', () => {
    const colorMode = useColorMode()
    const appConfig = useAppConfig()
    const config = useRuntimeConfig()
    const { t, locale, setLocale } = useI18n()

    const colors = ['red', 'orange', 'amber', 'yellow', 'lime', 'green', 'emerald', 'teal', 'cyan', 'sky', 'blue', 'indigo', 'violet', 'purple', 'fuchsia', 'pink', 'rose']
    const neutrals = ['slate', 'gray', 'zinc', 'neutral', 'stone']

    const user = ref({
        name: 'Mathieu-ai',
        avatar: {
            src: 'https://github.com/mathieu-ai.png',
            alt: 'Mathieu-ai'
        }
    })

  type LocaleOption = { code: string; name: string; flag: string }
  const i18nLocales = (config.public?.i18n?.locales as LocaleOption[])

  const items = computed<DropdownMenuItem[][]>(() => ([
      [
          {
              type: 'label',
              label: user.value.name,
              avatar: user.value.avatar
          }
      ],
      [
          {
              label: t('profile'),
              icon: 'i-lucide-user'
          },
          {
              label: t('billing'),
              icon: 'i-lucide-credit-card'
          },
          {
              label: t('settings'),
              icon: 'i-lucide-settings',
              to: '/settings'
          }
      ],
      [
          {
              label: t('language') || 'Language',
              icon: 'i-lucide-globe',
              children: i18nLocales.map(l => ({
                  label: `${l.flag} ${l.name}`,
                  type: 'checkbox',
                  checked: locale.value === l.code,
                  onSelect: () => { setLocale(l.code as typeof locale.value) }
              }))
          }
      ],
      [
          {
              label: t('theme'),
              icon: 'i-lucide-palette',
              children: [
                  {
                      label: t('primary'),
                      chip: {
                          color: appConfig.ui.colors.primary
                      },
                      content: {
                          align: 'center',
                          collisionPadding: 16
                      },
                      children: colors.map(color => ({
                          label: color,
                          chip: {
                              color: color
                          },
                          checked: appConfig.ui.colors.primary === color,
                          type: 'checkbox',
                          onSelect: (e) => {
                              e.preventDefault()
                              appConfig.ui.colors.primary = color
                          }
                      }))
                  },
                  {
                      label: 'Neutral',
                      chip: {
                          color: appConfig.ui.colors.neutral === 'neutral' ? 'old-neutral' : appConfig.ui.colors.neutral
                      },
                      content: {
                          align: 'end',
                          collisionPadding: 16
                      },
                      children: neutrals.map(color => ({
                          label: color,
                          chip: {
                              color: color === 'neutral' ? 'old-neutral' : color
                          },
                          type: 'checkbox',
                          checked: appConfig.ui.colors.neutral === color,
                          onSelect: (e) => {
                              e.preventDefault()
                              appConfig.ui.colors.neutral = color
                          }
                      }))
                  }
              ]
          }
      ],
      [
          {
              label: t('appearance'),
              icon: 'i-lucide-sun-moon',
              children: [
                  {
                      label: t('light') || 'Light',
                      icon: 'i-lucide-sun',
                      type: 'checkbox',
                      checked: colorMode.value === 'light',
                      onSelect(e: Event) {
                          e.preventDefault()
                          colorMode.value = 'light'
                      }
                  },
                  {
                      label: t('dark'),
                      icon: 'i-lucide-moon',
                      type: 'checkbox',
                      checked: colorMode.value === 'dark',
                      onUpdateChecked(checked: boolean) {
                          if (checked) {
                              colorMode.value = 'dark'
                          }
                      },
                      onSelect(e: Event) {
                          e.preventDefault()
                      }
                  }
              ]
          }
      ],
      [
          {
              label: t('logOut'),
              icon: 'i-lucide-log-out'
          }
      ]
  ]))

  return {
      items,
      user,
      colorMode,
      appConfig,
      i18nLocales,
      locale,
      setLocale
  }
})
