module Scriptures
  module Verses
    module Controllers
        class VersesController < ApplicationController
        # Shorthand definition
        Verse = Scriptures::Verses::Models::Verse
        VerseForm = Scriptures::Verses::Forms::VerseForm

          def index
            records = Verse.all
            render json: records
          end

          def show
            record = Verse.find(params[:id])
            render json: record
          end

          def create
            form = VerseForm.new(permitted_params)
            if form.save
              render json: form.record, status: :created
            else
              render json: { errors: form.errors }, status: :unprocessable_entity
            end
          end

          def update
            record = Verse.find(params[:id])
            form = VerseForm.new(permitted_params)

            if form.update(record) # Assumindo que seu Form Object terá um método `update`
              render json: form.record
            else
              render json: { errors: form.errors }, status: :unprocessable_entity
            end
          end

          def destroy
            record = Verse.find(params[:id])
            record.destroy
            head :no_content
          end

          private

          def permitted_params
            params.require(:verse).permit()
          end
        end
    end
  end
end
