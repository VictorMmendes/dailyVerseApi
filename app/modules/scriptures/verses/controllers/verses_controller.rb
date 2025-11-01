module Scriptures
  module Verses
    class VersesController < ApplicationController
      # Shorthand definition
      Verse = Scriptures::Verses::Verse
      VerseForm = Scriptures::Verses::VerseForm
      VerseCreatorService = Scriptures::Verses::VerseCreatorService

          def index
            @verses = Verse.all
            render json: @verses
          end

          def show
            @verse = Verse.find(params[:id])
            render json: @verse
          end

          def create
            creator = VerseCreatorService.new(verse_params)
            result = creator.call

            if result.is_a?(Verse)
              render json: result, status: :created
            else # Se o resultado for o form, ele tem os erros
              render json: { errors: result.errors }, status: :unprocessable_entity
            end
          end

          def update
            @verse = Verse.find(params[:id])
            form = VerseForm.new(verse_params)

            if form.update(@verse) # Assumindo que seu Form Object terá um método `update`
              render json: form.verse
            else
              render json: { errors: form.errors }, status: :unprocessable_entity
            end
          end

          def destroy
            @verse = Verse.find(params[:id])
            @verse.destroy
            head :no_content
          end

          private

          def verse_params
            params.require(:verse).permit(:content, :reference)
          end
        end
    end
  end
