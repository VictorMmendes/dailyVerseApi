class ApplicationController < ActionController::API

  private

  # Helper para renderizar o resultado de qualquer operação (Command ou Query)
  # que retorna um Result Object (com #success?, #value, #errors)
  def render_operation_result(result, success_status: :ok, failure_status: :unprocessable_entity)
    if result.success?
      render json: result.value, status: success_status
    else
      # Queries podem retornar :not_found, Comandos podem retornar :unprocessable_entity
      render json: { errors: result.errors }, status: failure_status
    end
  end
end
