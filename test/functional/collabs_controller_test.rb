require 'test_helper'

class CollabsControllerTest < ActionController::TestCase
  setup do
    @collab = collabs(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:collabs)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create collab" do
    assert_difference('Collab.count') do
      post :create, collab: { course_id: @collab.course_id, file: @collab.file, title: @collab.title }
    end

    assert_redirected_to collab_path(assigns(:collab))
  end

  test "should show collab" do
    get :show, id: @collab
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @collab
    assert_response :success
  end

  test "should update collab" do
    put :update, id: @collab, collab: { course_id: @collab.course_id, file: @collab.file, title: @collab.title }
    assert_redirected_to collab_path(assigns(:collab))
  end

  test "should destroy collab" do
    assert_difference('Collab.count', -1) do
      delete :destroy, id: @collab
    end

    assert_redirected_to collabs_path
  end
end
