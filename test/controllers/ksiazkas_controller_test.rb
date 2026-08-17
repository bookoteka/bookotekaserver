require "test_helper"

class KsiazkasControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get ksiazkas_index_url
    assert_response :success
  end

  test "should get new" do
    get ksiazkas_new_url
    assert_response :success
  end

  test "should get create" do
    get ksiazkas_create_url
    assert_response :success
  end

  test "should get show" do
    get ksiazkas_show_url
    assert_response :success
  end

  test "should get edit" do
    get ksiazkas_edit_url
    assert_response :success
  end

  test "should get update" do
    get ksiazkas_update_url
    assert_response :success
  end

  test "should get destroy" do
    get ksiazkas_destroy_url
    assert_response :success
  end
end
