require 'test_helper'

class HomeControllerTest < ActionController::TestCase
  test "should get acerca_de" do
    get :acerca_de
    assert_response :success
  end

  test "should get contacto" do
    get :contacto
    assert_response :success
  end

  test "should get precios" do
    get :precios
    assert_response :success
  end

  test "should get terminos_y_condiciones" do
    get :terminos_y_condiciones
    assert_response :success
  end

  test "should get politicas_de_privacidad" do
    get :politicas_de_privacidad
    assert_response :success
  end

  test "should get poliza_de_privacidad" do
    get :poliza_de_privacidad
    assert_response :success
  end

  test "should get app_nativas" do
    get :app_nativas
    assert_response :success
  end

end
