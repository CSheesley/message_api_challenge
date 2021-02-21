recipients to try:

get '/api/v1/messages'

*required params*


params: {
  **recipient**: 'corey'
}
example request
response

get '/api/v1/messages'
params: {
  **recipient: 'corey',
  sender: 'abbey' }
example request
response



post '/api/v1/messages',
params: {
  **recipient**: 'abbey',
  **sender**: 'corey',
  **body**: 'a short message'
}
