require 'rails_helper'

RSpec.describe 'Todos API', type: :request do
  # setup an ownder for the todos
  let(:user) { create(:user) }
  # Setup some test data
  let!(:todos) { create_list(:todo, 10, created_by: user.id) }
  let(:todo_id) { todos.first.id }
  # For making requests
  let(:headers) { valid_headers }

  describe 'GET todos' do
    before { get '/todos', params: {}, headers: headers }
    it 'returns todos' do
      expect(json).not_to be_empty
      expect(json.size).to eq(10)
    end
    it 'has status code 200' do
      expect(response).to have_http_status(200)
    end
  end

  describe 'GET todos/:id' do
    before { get "/todos/#{todo_id}", params: {}, headers: headers }

    context 'When the record exists' do
      it 'returns the requested todo' do
        expect(json).not_to be_empty
        expect(json['id']).to eq(todo_id)
      end
      it 'has status code 200' do
        expect(response).to have_http_status(200)
      end
    end
    context 'When the record does not exist' do
      let(:todo_id) { 100 }
      it 'has status code 404' do
        expect(response).to have_http_status(404)
      end
      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Todo/)
      end
    end
  end

  describe 'POST /todos' do
    let(:expected_title) { 'Learn Elm' }
    let(:valid_attributes) do
      { title: 'Learn Elm', created_by: user.id.to_s }.to_json
    end
    context 'When the request is valid' do
      before { post '/todos', params: valid_attributes, headers: headers }
      it 'creates a todo' do
        expect(json['title']).to eq(expected_title)
      end
      it 'has status code 201' do
        expect(response).to have_http_status(201)
      end
    end
    context 'When the request is invalid' do
      let(:valid_attributes) { { title: nil }.to_json }
      before { post '/todos', params: valid_attributes, headers: headers }

      it 'has a status code 422' do
        expect(response).to have_http_status(422)
      end
      it 'returns a failure message' do
        expect(response.body)
          .to match(/Validation failed: Title can't be blank/)
      end
    end
  end

  describe 'PUT /todos/:id' do
    let(:valid_attributes) { { title: 'Shopping' }.to_json }
    context 'When the record exists' do
      before do
        put "/todos/#{todo_id}", params: valid_attributes, headers: headers
      end
      it 'updates the record' do
        expect(response.body).to be_empty
      end
      it 'has status code 204' do
        expect(response).to have_http_status(204)
      end
    end
  end

  describe 'DELETE /todos/:id' do
    before { delete "/todos/#{todo_id}", params: {}, headers: headers }
    it 'returns status code 204' do
      expect(response).to have_http_status(204)
    end
  end
end
