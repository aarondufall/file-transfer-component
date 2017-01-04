module FileTransferComponent
  class Projection
    include EntityProjection
    include Messages::Events

    entity_name :file

    # apply AccountOpened do |account_opened|
    #   SetAttributes.(account, account_opened, copy: [
    #     { account_id: :id },
    #     :customer_id,
    #     :sequence
    #   ])

    #   account.opened_time = Time.parse(account_opened.time)
    # end


  end
end
