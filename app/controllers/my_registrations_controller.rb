class MyRegistrationsController < Devise::RegistrationsController
  def create
    super
    distinct_id = current_user.id
    tracker = Mixpanel::Tracker.new(ENV['MIXPANEL_TOKEN'])
    tracker.people.set(distinct_id, {
      '$email' => current_user.email
      })

    p params
    p 'I can do it!!!!!!!!!!!!!!!'
  end
end
