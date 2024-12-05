#Add Deposit Request Locators
dashboard_tab = "//a[text()='Dashboard']"
add_deposit_request_tab = "//a[text()='Add Deposit Requests']"
other_bank_details_tab = "//h3[text()='Other Bank Details']"
add_deposit_type_locator = "//input[@id='type']"
submit_btn = "//button[text()='Submit']"
deposit_request_note_close_button = "//button[@class='styles_closeButton__20ID4']"
deposit_amount = "//input[@id='requestedAmount']"
deposit_agent_bank_name = "//input[@id='depositBank']"
deposit_agent_deposit_branch = "//input[@id='depositBranch']"
# atlas_bank_name_input = "//div[@class='search__form__section__wrapper']/div[5]/descendant::input"
atlas_bank_name_input = '(//div[@class="css-10nd86i byDefault-mutiselect react-select-container"]//input)[1]'
# atlas_account_number = "//div[@class='search__form__section__wrapper']/div[6]/descendant::input"
atlas_account_number = '(//div[@class="css-10nd86i byDefault-mutiselect react-select-container"]//input)[2]'
deposit_transaction_id = "//input[@id='transactionId']"
deposit_mobile = "//input[@id='mobile']"
deposit_cheque_draw_on_bank = "//input[@id='chequeDrawOnBank']"
deposit_cheque_issue_date = "//input[@id='chequeIssueDate']"
deposit_cheque_number = "//input[@id='chequeNumber']"
