require 'rails_helper'

RSpec.feature "動作に関するテスト", type: :feature do
  before do
    2.times do
      FactoryBot.create(:book)
    end
  end
  scenario "トップ画面(root_path)に新規投稿ページへのリンクが表示されているか" do
    visit root_path
    expect(page).to have_link "", href: books_path
  end
  feature "bookの一覧ページの表示とリンクは正しいか" do
    before do
      visit books_path
    end
    scenario "bookの一覧表示(tableタグ)と投稿フォームが同一画面に表示されているか" do
      has_field?('body')
      has_table?('body')
    end
    scenario "bookのタイトルと感想を表示し、詳細・編集・削除のリンクが表示されているか" do
      Book.all.each do |book|
        expect(page).to have_content book.title
        expect(page).to have_content book.body
        expect(page).to have_link "", href: book_path(book)
        expect(page).to have_link "", href: edit_book_path(book)
        expect(page).to have_link "", href: book_path(book)
      end
    end
  end
  feature "bookの詳細ページへの表示内容とリンクは正しいか" do
    given(:book) {Book.first}
    before do
      visit book_path(book)
    end
    scenario "bookの詳細内容と新規登録、編集ページへのリンクが表示されているか" do
      expect(page).to have_content book.title
      expect(page).to have_content book.body
      expect(page).to have_link "", href: edit_book_path(book)
      expect(page).to have_link "", href: books_path
    end
  end
  feature "bookを投稿" do
    before do
      visit books_path
      fill_in 'book[title]', with: 'title_a'
      fill_in 'book[body]', with: 'body_b'
    end
    scenario "正しく保存できているか" do
      expect{
        find("input[name='commit']").click
      }.to change(Book, :count).by(1)
    end
    scenario "リダイレクト先は正しいか" do
      find("input[name='commit']").click
      expect(page).to have_current_path book_path(Book.last)
    end
    scenario "サクセスメッセージは正しく表示されるか" do
      find("input[name='commit']").click
      expect(page).to have_content "successfully"
    end
  end
  feature "bookの更新" do
    before do
      book = Book.first
      visit edit_book_path(book)
      fill_in 'book[title]', with: 'update_title_a'
      fill_in 'book[body]', with: 'update_body_b'
    end
    scenario "bookが更新されているか" do
      find("input[name='commit']").click
      expect(page).to have_content "update_title_a"
      expect(page).to have_content "update_body_b"
    end
    scenario "リダイレクト先は正しいか" do
      find("input[name='commit']").click
      expect(page).to have_current_path book_path(Book.first)
    end
    scenario "サクセスメッセージが表示されているか" do
      find("input[name='commit']").click
      expect(page).to have_content "successfully"
    end
  end
  feature "bookの削除" do
    before do
      visit books_path
    end
    scenario "bookが削除されているか" do
      expect {
      all("a[data-method='delete']").select{|n| n[:href] == book_path(Book.first)}[0].click
      }.to change(Book, :count).by(-1)
    end
    scenario "リダイレクト先が正しいか" do
      all("a[data-method='delete']").select{|n| n[:href] == book_path(Book.first)}[0].click
      expect(page).to have_current_path books_path
    end
  end
end
