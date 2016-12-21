
#the below code is for stripe validation. Once i enter vallid stripe test creditcard details "4242424242424242" which are available
#on their site. and enter it into buy a product. The code below varifys it and stripe sends me a token number.
# Once you see the token alert which appears after you enter a valid test number. you get an alert with a stripe token
jQuery ->
  Stripe.setPublishableKey($('meta[name="stripe-key"]').attr('content'))
  payment.setupForm()

payment =
  setupForm: ->
    $('#new_order').submit ->
      $('input[type=submit]').attr('disabled', true)
      Stripe.card.createToken($('#new_order'), payment.handleStripeResponse)
      false

  handleStripeResponse: (status, response) ->
    if status == 200
      $('#new_order').append($('<input type="hidden" name="stripeToken" />').val(response.id))
      $('#new_order')[0].submit()
      alert(response.id)
    else
      alert(response.error.message)
