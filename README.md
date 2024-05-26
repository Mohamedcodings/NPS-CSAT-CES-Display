# NPS-CSAT-CES-Display

NPS-CSAT-CES-Display is a Ruby on Rails application designed to upload, display, and analyze customer satisfaction surveys. The application calculates Net Promoter Score (NPS), Customer Satisfaction (CSAT), and Customer Effort Score (CES) from uploaded Excel files and presents the data in a user-friendly dashboard.

## Features

- **Upload Surveys**: Upload Excel files containing customer satisfaction survey data.
- **Display Surveys**: Display survey results categorized by NPS, CSAT, and CES.
- **Calculate Scores**: Automatically calculate NPS, CSAT, and CES scores.
- **Detailed Insights**: View the count of each survey score.

## Installation

### Prerequisites

- Ruby 3.2.1
- Rails 7.1.3.3
- Node.js
- Yarn

### Setup

1. Clone the repository:

    ```sh
    git clone git@github.com:Mohamedcodings/NPS-CSAT-CES-Display.git
    cd NPS-CSAT-CES-Display
    ```

2. Install dependencies:

    ```sh
    bundle install
    yarn install
    ```

3. Set up the database:

    ```sh
    rails db:create
    rails db:migrate
    ```

### Running the Application

1. Start the Rails server:

    ```sh
    rails server
    ```

2. Open your web browser and go to `http://localhost:3000`.

## Usage

1. **Upload Surveys**: Click on the "Choose file" button to select an Excel file and then click "Upload".
2. **View Results**: The uploaded surveys will be displayed categorized by NPS, CSAT, and CES with their respective scores and timestamps.
3. **Analyze Scores**: View the calculated NPS, CSAT, and CES scores along with the count of each score.

## Sample Data

Use the provided sample Excel files to test the application:

- `customer_satisfaction_surveys_1.xlsx`
- `customer_satisfaction_surveys_2.xlsx`
