require 'test_helper'

class ApiControllerTest < ActionController::TestCase
  test "should get vista_para_respuesta" do
    get :vista_para_respuesta
    assert_response :success
  end

  test "should get vista_gracias_respuesta" do
    get :vista_gracias_respuesta
    assert_response :success
  end

end
