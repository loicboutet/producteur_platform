import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="stripe-payment"
export default class extends Controller {
  static values = {
    publishableKey: String,
    clientSecret: String,
    confirmUrl: String
  }

  static targets = ["card", "errors", "submit", "buttonText", "spinner"]

  connect() {
    console.log("Stripe Payment controller connected")
    this.initializeStripe()
  }

  async initializeStripe() {
    // Charger Stripe
    if (typeof Stripe === 'undefined') {
      console.error("Stripe.js not loaded")
      return
    }

    this.stripe = Stripe(this.publishableKeyValue)
    const elements = this.stripe.elements()

    // Créer l'élément de carte
    this.cardElement = elements.create('card', {
      style: {
        base: {
          fontSize: '16px',
          color: '#32325d',
          fontFamily: '-apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, "Helvetica Neue", Arial, sans-serif',
          '::placeholder': {
            color: '#aab7c4'
          }
        },
        invalid: {
          color: '#fa755a',
          iconColor: '#fa755a'
        }
      }
    })

    // Monter l'élément dans le DOM
    this.cardElement.mount(this.cardTarget)
    console.log("Card element mounted")

    // Gérer les erreurs de validation en temps réel
    this.cardElement.on('change', (event) => {
      if (event.error) {
        this.errorsTarget.textContent = event.error.message
      } else {
        this.errorsTarget.textContent = ''
      }
    })
  }

  async submitPayment(event) {
    event.preventDefault()
    console.log("Submitting payment...")

    // Désactiver le bouton
    this.submitTarget.disabled = true
    this.buttonTextTarget.classList.add('hidden')
    this.spinnerTarget.classList.remove('hidden')

    try {
      const { error, paymentIntent } = await this.stripe.confirmCardPayment(
        this.clientSecretValue,
        {
          payment_method: {
            card: this.cardElement
          }
        }
      )

      if (error) {
        // Afficher l'erreur
        this.errorsTarget.textContent = error.message
        this.resetButton()
      } else {
        // Paiement réussi
        if (paymentIntent.status === 'succeeded') {
          console.log("Payment succeeded, redirecting...")
          window.location.href = this.confirmUrlValue
        }
      }
    } catch (error) {
      console.error('Payment error:', error)
      this.errorsTarget.textContent = 'An unexpected error occurred. Please try again.'
      this.resetButton()
    }
  }

  resetButton() {
    this.submitTarget.disabled = false
    this.buttonTextTarget.classList.remove('hidden')
    this.spinnerTarget.classList.add('hidden')
  }
}
