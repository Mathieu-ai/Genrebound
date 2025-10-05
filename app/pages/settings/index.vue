<script setup lang="ts">
import { ref } from 'vue'
import { useRouter } from 'vue-router'

const router = useRouter()

const generalOpen = ref(true)
const accountOpen = ref(false)
</script>

<template>
	<UDashboardPanel id="settings">
		<template #header>
			<UDashboardNavbar :title="$t('settings')">
				<template #leading>
					<UButton icon="i-lucide-arrow-left" variant="ghost" color="neutral" @click="router.back()" />
				</template>
			</UDashboardNavbar>
		</template>

		<template #body>
			<div class="grid gap-4 grid-cols-1 lg:grid-cols-2">
				<UCard class="p-4">
					<template #header>
						<div class="flex items-center justify-between">
							<h3 class="text-lg font-medium">{{$t('general')}}</h3>
							<UButton size="sm" variant="ghost" @click="generalOpen = !generalOpen">{{$t('toggle')}}</UButton>
						</div>
					</template>

					<template #default>
						<div v-if="generalOpen" class="text-sm text-muted-foreground">
							{{$t('generalSettingsPlaceholder')}}
						</div>
					</template>
				</UCard>

				<UCard class="p-4">
					<template #header>
						<div class="flex items-center justify-between">
							<h3 class="text-lg font-medium">{{$t('account')}}</h3>
							<UButton size="sm" variant="ghost" @click="accountOpen = !accountOpen">{{$t('toggle')}}</UButton>
						</div>
					</template>

					<template #default>
						<div v-if="accountOpen" class="text-sm text-muted-foreground">
							{{$t('accountSettingsPlaceholder')}}
						</div>
					</template>
				</UCard>
			</div>
		</template>
	</UDashboardPanel>
</template>

