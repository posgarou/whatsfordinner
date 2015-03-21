require_relative 'token_headers'
require_relative 'response_helpers'

shared_examples_for 'an authenticated resource' do |valid_user, method, resource_path, params|
  include TokenHeaders
  include ResponseHelpers

  let(:authenticating_user) { valid_user.is_a?(Symbol) ? (send valid_user) : valid_user }

  let(:path) { resource_path.is_a?(Symbol) ? (send resource_path) : resource_path }

  let(:headers) { valid_headers(authenticating_user) }

  after do
    Timecop.return
  end

  it 'does not allow access with no token' do
    invalid_headers = headers.tap { |h| h.delete 'Access-Token' }

    send method, path, params, invalid_headers

    expect_401
  end

  it 'does not allow access with no uid' do
    invalid_headers = headers.tap { |h| h.delete 'Uid' }

    send method, path, params, invalid_headers

    expect_401
  end

  it 'does not allow access with a nonsensical token' do
    invalid_headers = headers.tap { |h| h['Access-Token'] = 'i am a hacker' }

    send method, path, params, invalid_headers

    expect_401
  end

  it 'does not allow access with an expired token' do
    invalid_headers = headers

    Timecop.travel(2.weeks.from_now + 1.second)

    send method, path, params, invalid_headers

    expect_401
  end
end
