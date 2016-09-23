require 'test_helper'

class WikiControllerTest < ActionController::TestCase
  test "should get acceso_a_la_wiki" do
    get :acceso_a_la_wiki
    assert_response :success
  end

  test "should get registro_en_wiki" do
    get :registro_en_wiki
    assert_response :success
  end

  test "should get solicitar_codigo_wiki" do
    get :solicitar_codigo_wiki
    assert_response :success
  end

  test "should get ver_tutoriales" do
    get :ver_tutoriales
    assert_response :success
  end

  test "should get evaluar_conocimiento_app_moobile" do
    get :evaluar_conocimiento_app_moobile
    assert_response :success
  end

end
