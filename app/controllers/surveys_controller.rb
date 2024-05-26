class SurveysController < ApplicationController
  def index
    @nps_surveys = Survey.where(survey_type: 'NPS')
    @csat_surveys = Survey.where(survey_type: 'CSAT')
    @ces_surveys = Survey.where(survey_type: 'CES')

    @nps_score = calculate_nps(@nps_surveys)
    @csat_score = calculate_csat(@csat_surveys)
    @ces_score = calculate_ces(@ces_surveys)

    @nps_score_counts = count_scores(@nps_surveys)
    @csat_score_counts = count_scores(@csat_surveys)
    @ces_score_counts = count_scores(@ces_surveys)
  end

  def new
  end

  def create
    file = params[:file]
    if file.nil?
      flash[:alert] = "Please select a file."
      render :new
      return
    end

    if process_file(file)
      redirect_to surveys_path, notice: "Surveys imported successfully."
    else
      flash[:alert] = "There was a problem processing the file. Please check the format and try again."
      render :new
    end
  rescue => e
    logger.error "Failed to process file: #{e.message}"
    flash[:alert] = "There was a problem processing the file. Please check the format and try again."
    render :new
  end

  private

  def process_file(file)
    workbook = RubyXL::Parser.parse(file.path)
    workbook.worksheets.each do |worksheet|
      worksheet.each_with_index do |row, index|
        next if index == 0 # Skip header row

        survey_id, survey_type, score, comment, timestamp = row.cells.map { |cell| cell&.value.to_s.strip }

        begin
          parsed_timestamp = DateTime.parse(timestamp)
        rescue ArgumentError => e
          logger.error "Failed to parse timestamp: #{timestamp}. Error: #{e.message}"
          parsed_timestamp = nil
        end

        Survey.create!(
          survey_type: survey_type,
          score: score.to_i,
          comment: comment,
          timestamp: parsed_timestamp
        )
      end
    end
    return true
  rescue => e
    logger.error "Failed to process worksheet: #{e.message}"
    return false
  end

  def calculate_nps(surveys)
    total_responses = surveys.count
    promoters = surveys.where("score >= 9").count
    passives = surveys.where("score >= 7 and score < 9").count
    detractors = surveys.where("score < 7").count

    nps = ((promoters - detractors) / total_responses.to_f) * 100
    nps.round(2)
  end

  def calculate_csat(surveys)
    total_responses = surveys.count
    satisfied = surveys.where("score >= 4").count

    csat = (satisfied / total_responses.to_f) * 100
    csat.round(2)
  end

  def calculate_ces(surveys)
    total_responses = surveys.count
    easy = surveys.where("score >= 4").count

    ces = (easy / total_responses.to_f) * 100
    ces.round(2)
  end

  def count_scores(surveys)
    surveys.group(:score).count
  end
end
