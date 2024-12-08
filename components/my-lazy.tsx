// Composables
import { makeComponentProps } from 'vuetify/lib/composables/component.mjs'
import { makeDimensionProps, useDimension } from 'vuetify/lib/composables/dimensions'
import { useProxiedModel } from 'vuetify/lib/composables/proxiedModel'
import { makeTagProps } from 'vuetify/lib/composables/tag'
import { makeTransitionProps, MaybeTransition } from 'vuetify/lib/composables/transition'

// Directives
import intersect from 'vuetify/lib/directives/intersect'

// Utilities
import { genericComponent, propsFactory, useRender } from 'vuetify/lib/util'

// Types
import type { PropType } from 'vue'

export const makeMyLazyProps = propsFactory({
  modelValue: Boolean,
  options: {
    type: Object as PropType<IntersectionObserverInit>,
    // For more information on types, navigate to:
    // https://developer.mozilla.org/en-US/docs/Web/API/Intersection_Observer_API
    default: () => ({
      root: undefined,
      rootMargin: undefined,
      threshold: undefined,
    }),
  },

  ...makeComponentProps(),
  ...makeDimensionProps(),
  ...makeTagProps(),
  ...makeTransitionProps({ transition: 'fade-transition' }),
}, 'MyLazy')

const MyLazy = genericComponent()({
  name: 'MyLazy',

  directives: { intersect },

  props: makeMyLazyProps(),

  emits: {
    'update:modelValue': (value: boolean) => true,
  },

  setup (props, { slots }) {
    const { dimensionStyles } = useDimension(props)

    const isActive = useProxiedModel(props, 'modelValue')

    function onIntersect (isIntersecting: boolean) {
      console.log(`onIntersect`, isIntersecting)
      // if (isActive.value) return

      isActive.value = isIntersecting
    }

    useRender(() => (
      <props.tag
        class={[
          'my-lazy',
          props.class,
        ]}
        v-intersect={[
          {
            handler: onIntersect,
            options: props.options,
          },
          null,
          isActive.value ? [] : ['once'],
        ]}
        style={[
          dimensionStyles.value,
          props.style,
        ]}
      >
        { isActive.value && (
          <MaybeTransition transition={ props.transition } appear>
            { slots.default?.() }
          </MaybeTransition>
        )}
      </props.tag>
    ))

    return {}
  },
})

export type MyLazy = InstanceType<typeof MyLazy>
export default MyLazy