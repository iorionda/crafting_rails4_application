require 'test_helper'

class NavigationTest < ActiveSupport::IntegrationCase
  setup do
    ActionMailer::Base.deliveries.clear
  end

  test 'sends an e-mail after filling the contact form' do
    visit '/'

    fill_in 'Name', with: 'Jhon Doe'
    fill_in 'Email', with: 'jhon.doe@example.com'
    fill_in 'Message', with: 'MailForm rocks!'

    click_button 'Deliver'

    assert_match 'Your message was successfully send.', page.body

    assert_equal 1, ActionMailer::Base.deliveries.size
    mail = ActionMailer::Base.deliveries.last

    assert_equal ['jhon.doe@example.com'], mail.from
    assert_equal ['recipient@example.com'], mail.to
    assert_match 'Message: MailForm rocks!', mail.body.encoded
  end
end
