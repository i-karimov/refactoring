class Users::Create < ActiveInteraction::Base
  float :x

  def execute
    x ** 2
  end
end
