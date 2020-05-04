<template>
  <div id="app">
    <a href="https://github.com/virvum/alcoholism" class="github-link">
      <img width="149" height="149" src="https://github.blog/wp-content/uploads/2008/12/forkme_right_darkblue_121621.png?resize=149%2C149" class="attachment-full size-full" alt="Fork me on GitHub" data-recalc-dims="1">
    </a>

    <h1>Rettich Coefficient Calculator</h1>

    <div class="products">
      <p>Product presets:</p>
      <a v-for="(p, index) in products" :key="index" @click="loadProduct(p)" href="javascript:void(0)">{{ p.name }} ({{ p.store }})</a>
    </div>

    <div>
      <x-input v-model="amount" label="Amount (use affix L, dL, cL or mL)" type="text" />
      <x-input v-model="alcohol" label="Alcohol (volume %)" type="text" />
      <x-input v-model="price" label="Price (in CHF)" type="text" />
    </div>

    <div class="result">
      <div>
        <p>Rettich Coefficient</p>
        <p>{{ rettichCoefficient }}</p>
      </div>
      <div>
        <p>Price per mL of pure ethanol (CHF)</p>
        <p>{{ ethanolPrice }}</p>
      </div>
      <div>
        <p>Absolute ethanol (mL)</p>
        <p>{{ ethanol }}</p>
      </div>
      <div>
        <p>Shots of pure ethanol (20 mL)</p>
        <p>{{ shots }}</p>
      </div>
    </div>
  </div>
</template>

<script>
export default {
  data: () => ({
    units: {
      l: {
        name: 'litre',
        f: v => v * 1000,
      },
      dl: {
        name: 'decilitre',
        f: v => v * 100,
      },
      cl: {
        name: 'centilitre',
        f: v => v * 10,
      },
      ml: {
        name: 'millilitre',
        f: v => v,
      },
    },
    products: [
      {
        name: 'Prix Garantie Lager-Bier 24x50cl',
        store: 'Coop',
        amount: '12 L',
        alcohol: 4.8,
        price: 11.7,
      },
      {
        name: 'Anker Lager-Bier 24x50cl',
        store: 'Coop',
        amount: '12 L',
        alcohol: 4.8,
        price: 12.95,
      },
      {
        name: 'Löwenbräu Bier 24x50cl',
        store: 'Coop',
        amount: '12 L',
        alcohol: 5.2,
        price: 14.85,
      },
      {
        name: 'Absolut Original Vodka',
        store: 'Denner',
        amount: '0.7 L',
        alcohol: 40,
        price: 18.9,
      },
      {
        name: 'Grey Goose Vodka',
        store: 'Coop',
        amount: '0.7 L',
        alcohol: 40,
        price: 49.95,
      },
      {
        name: 'Belvedere Vodka',
        store: 'Coop',
        amount: '0.7 L',
        alcohol: 40,
        price: 49.95,
      },
      {
        name: 'Primakov Vodka',
        store: 'Coop',
        amount: '0.7 L',
        alcohol: 37.5,
        price: 9.85,
      },
      {
        name: 'Wodka Gorbatschow',
        store: 'Coop',
        amount: '1 L',
        alcohol: 37.5,
        price: 21.95,
      },
      /*
      {
        name: '',
        store: '',
        amount: '',
        alcohol: ,
        price: ,
      },
      */
    ],
    amount: 0,
    alcohol: 0,
    price: 0,
  }),
  computed: {
    ml () {
      const m = /^(?<value>[0-9.,]+)\s*(?<unit>[^0-9]+)$/.exec(this.amount)

      if (m === null) {
        return 0
      }

      const unit = m.groups.unit.toLowerCase()

      if ((unit in this.units) === false) {
        return 0
      }

      return this.units[unit].f(parseFloat(m.groups.value))
    },
    rettichCoefficient () {
      return this.price > 0 ? this.numberFormat((this.ml * this.alcohol / 100) / this.price) : '∞'
    },
    ethanolPrice () {
      return this.ml > 0 && this.alcohol > 0 && this.price > 0 ? this.numberFormat(this.price / (this.ml * this.alcohol / 100)) : '?'
    },
    ethanol () {
      return this.ml > 0 && this.alcohol > 0 ? this.numberFormat(this.alcohol / 100 * this.ml) : '?'
    },
    shots () {
      return this.ml > 0 && this.alcohol > 0 ? this.numberFormat(this.alcohol / 100 * this.ml / 20) : '?'
    },
  },
  methods: {
    numberFormat (n) {
      return new Intl.NumberFormat('de-CH', { maximumFractionDigits: 2 }).format(n)
    },
    colorGradient (a, b, value, min = 0, max = 1) {
      return {
        r: Math.floor(),
        g: Math.floor(),
        b: Math.floor(),
      }
    },
    loadProduct (p) {
      this.amount = p.amount
      this.alcohol = p.alcohol
      this.price = p.price
    },
  },
}
</script>

<style lang="sass">
html, body, #app
  width: 100%
  height: 100%

*
  margin: 0
  padding: 0
  box-sizing: border-box
  outline: 0
  color: #000
  background: transparent
  font-family: sans-serif

input
  padding: 5px
  border: 1px solid #ddd
  border-radius

h1
  text-align: center

#app
  padding: 20px 0 20px 0
  display: flex
  flex-direction: column
  align-items: center

#app > div
  margin: 20px 0 20px 0

.github-link
  position: fixed
  top: 0
  right: 0

.products
  display: flex
  flex-direction: column
  align-items: center

  & > p
    margin-bottom: 20px

  & > a
    display: block

.result
  display: flex
  flex-direction: row
  flex-wrap: wrap
  align-items: center
  justify-content: center

  & > div
    width: 300px
    height: 300px
    margin: 20px
    display: flex
    flex-direction: column
    align-items: center
    justify-content: center
    background: #ddd
    text-align: center
    border-radius: 100%

  & > div > p:nth-child(2)
    font-size: 666%
    font-weight: bold
</style>
