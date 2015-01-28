require 'spec_helper'

feature "User requests" do


	scenario "home page" do

		visit "/"
		expect(page).to have_selector("h1", text:"Home page")

	end

	scenario "contact" do

		visit "/contact/"

		expect(page).to have_selector("h1", text:"Contact Us")

	end

	scenario "special" do

		visit "/special/"

		expect(page).to have_selector("h1", text:"A special page")

	end

	scenario "accounts" do

		visit "/help/accounts/"

		expect(page).to have_selector("h1", text:"Accounts Help")

	end

end
