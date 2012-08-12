require 'pubnub'

if ENV["DISABLE_PUBNUB"] != "true"
  
  puts('Creating new PubNub Client API')

  ## -----------------------------------------
  ## Create Pubnub Client API (INITIALIZATION)
  ## -----------------------------------------
  
  PUBNUB = Pubnub.new(
      'pub-ac572c62-7762-4e2e-9afb-a7620048edb0',
      'sub-f5b1501e-a0fc-11e1-a6de-d1b91d67d2fc',
      'sec-MTU2ZDMxZTQtZDJhYS00NjM0LTk5NDEtNTU4OGE0M2Q3OGQ3',
      '',
      false
  )  
  
else
  puts("Pubnub disabled")
end 