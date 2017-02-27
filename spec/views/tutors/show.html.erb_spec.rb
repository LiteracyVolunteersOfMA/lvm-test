require 'rails_helper'
require 'spec_helpr'

RSpec.describe 'tutors/show.html.erb', type: :view do
  xdescribe 'populate page and links' do
    before do
      @tutor = Tutor.create(
        first_name: 'Viviano', last_name: 'Cantu',
        email_preferred: 'email@email.com',
        address1: '200 Huntington St', city: 'Boston', state: 'MA',
        zip: '02120', home_phone: '1112223333', cell_phone: '4445556666',
        affiliate: 'Affiliate1', gender: 'male', native_language: 'English',
        race: 'white')
      @students = [Student.create(first_name: 'Mike', last_name: 'White'),
                   Student.create(first_name: 'Alex', last_name: 'Jones')]
      render
    end

    describe 'presence of tutors' do
      it 'checks for both coordinators names' do
        expect(rendered).to match(/Viviano Cantu/)
      end

      it 'checks for tutor email' do
        expect(rendered).to match(/email@email.com/)
      end

      it 'checks for tutor address' do
        expect(rendered).to match(/200 Huntington St/)
        expect(rendered).to match(/Boston/)
        expect(rendered).to match(/MA/)
        expect(rendered).to match(/02120/)
      end

      it 'checks for tutor phone numbers' do
        expect(rendered).to match(/1112223333/)
        expect(rendered).to match(/4445556666/)
      end

      it 'checks for tutor affiliate' do
        expect(rendered).to match(/Affiliate1/)
      end

      it 'checks for tutor gender' do
        expect(rendered).to match(/male/)
      end

      it 'checks for tutor race' do
        expect(rendered).to match(/White/)
      end

      it 'checks for tutor native language' do
        expect(rendered).to match(/English/)
      end
    end

    describe 'precence of students' do
      it 'checks for both students names' do
        expect(rendered).to match(/Mike White/)
        expect(rendered).to match(/Alex Jones/)
      end
    end

    describe 'links' do
      it 'checks for edit and back link' do
        assert_select 'a[href=?]', edit_tutor_path(@tutor)
        assert_select 'a[href=?]', tutors_path
      end

      it 'checks for student show links' do
        assert_select 'a[href=?]', student_show_path(@students[0])
        assert_select 'a[href=?]', student_show_path(@students[1])
      end
    end

    describe 'click links' do
      it 'checks for link path after clicking' do
        visit edit_tutor_path(@tutor)
        current_path.should eq(edit_tutor_path(@tutor))
      end

      it 'chekcs for student link path after clicking' do
        visit edit_tutor_path(@students[0])
        current_path.should eq(edit_tutor_path(@students[0]))
        visit edit_tutor_path(@students[1])
        current_path.should eq(edit_tutor_path(@students[1]))
    end
  end
end