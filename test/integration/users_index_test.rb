# frozen_string_literal: true

require 'test_helper'

class UsersIndexTest < ActionDispatch::IntegrationTest
  def setup
    @non_admin = users(:michael)
    @admin = users(:lana)
  end

  test 'index as non-admin' do
    log_in_as(@non_admin)
    get users_path
    assert_select 'a', text: 'Delete', count: 0
  end

  test 'index as admin including pagination and delete links' do
    log_in_as(@admin)
    first_page_of_users = User.paginate(page: 1)
    first_page_of_users.first.toggle!(:activated)
    get users_path
    assert_template 'users/index'
    assert_select 'div.pagination'
    assigns(:users).each do |user|
      # user.activated? tests that only activated users are being rendered,
      # as you can verify by removing the where clause in the index action.
      assert user.activated?
      assert_select 'a[href=?]', user_path(user), text: user.name
      unless user == @admin
        assert_select 'a[href=?]', user_path(user), text: 'Delete'
      end
    end
    assert_difference 'User.count', -1 do
      delete user_path(@non_admin)
    end
  end
end
