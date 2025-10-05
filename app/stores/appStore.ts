import { defineStore } from 'pinia'
import { ref, computed, watch, onMounted } from 'vue'
import { useI18n } from '#imports'
import { useStorage } from '@vueuse/core'
import type { NavigationMenuItem } from '@nuxt/ui'

export const useAppStore = defineStore('app', () => {
    const open = ref(false)
    const { t, locale } = useI18n()
    const toast = useToast()
    const cookie = useStorage('cookie-consent', 'pending')

    const links = computed(() => [[{
        label: t('home'),
        icon: 'i-lucide-house',
        to: '/',
        onSelect: () => {
            open.value = false
        }
    }]] as NavigationMenuItem[][])

    const groups = computed(() => [{
        id: 'links',
        label: t('goTo'),
        items: links.value.flat()
    }])

    function showCookieToast() {
        if (cookie.value !== 'accepted') {
            toast.add({
                id: 'cookie-consent',
                title: t('cookieConsent'),
                duration: 0,
                close: false,
                actions: [
                    {
                        label: t('accept'),
                        color: 'neutral',
                        variant: 'outline',
                        onClick: () => {
                            cookie.value = 'accepted'
                            toast.remove('cookie-consent')
                        }
                    },
                    {
                        label: t('optOut'),
                        color: 'neutral',
                        variant: 'ghost'
                    }
                ]
            })
        }
    }

    onMounted(showCookieToast)
    watch(locale, showCookieToast)

    return {
        open,
        links,
        groups,
        showCookieToast,
        cookie
    }
})
