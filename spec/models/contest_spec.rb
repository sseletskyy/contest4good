require 'spec_helper'

describe Contest do
  before(:each) do
    Contest4good::create_roles
    @admin = fg.create(:admin)
    @contest = fg.create(:contest)
  end

  it 'should return correct committee_head_ids' do

    @contest.committee_head_ids = []
    @contest.save(validate: false)
    @contest.committee_head_ids.should eq([])

    @admin.add_role :committee_head, @contest
    @contest = Contest.find @contest.id
    @contest.committee_head_ids.should eq([@admin.id])

    @admin.remove_role :committee_head, @contest
    @contest = Contest.find @contest.id
    @contest.committee_head_ids.should eq([])

    @contest.committee_head_ids = @admin.id
    @contest.save(validate: false)
    @contest = Contest.find @contest.id
    @contest.committee_head_ids.should eq([@admin.id])

  end

  it 'test committee_head_ids_changed?' do
    original = @contest.committee_head_ids
    @contest.committee_head_ids_changed?.should be_false
    @contest.committee_head_ids = []
    @contest.committee_head_ids_changed?.should be_true
    @contest.committee_head_ids = original
    @contest.committee_head_ids_changed?.should be_false
  end

  it 'should return correct jury_head_ids' do

    @contest.jury_head_ids = []
    @contest.save(validate: false)
    @contest.jury_head_ids.should eq([])

    @admin.add_role :jury_head, @contest
    @contest = Contest.find @contest.id
    @contest.jury_head_ids.should eq([@admin.id])

    @admin.remove_role :jury_head, @contest
    @contest = Contest.find @contest.id
    @contest.jury_head_ids.should eq([])

    @contest.jury_head_ids = [@admin.id]
    @contest.save(validate: false)
    @contest = Contest.find @contest.id
    @contest.jury_head_ids.should eq([@admin.id])
  end

  it 'should return correct jury_head_ids' do

    @contest.committee_vice_ids = []
    @contest.save(validate: false)
    @contest.committee_vice_ids.should eq([])

    @admin.add_role :committee_vice, @contest
    @contest = Contest.find @contest.id
    @contest.committee_vice_ids.should eq([@admin.id])

    @admin.remove_role :committee_vice, @contest
    @contest = Contest.find @contest.id
    @contest.committee_vice_ids.should eq([])

    @contest.committee_vice_ids = [@admin.id]
    @contest.save(validate: false)
    @contest = Contest.find @contest.id
    @contest.committee_vice_ids.should eq([@admin.id])
  end

  it 'should return correct jury_judge_ids' do

    @contest.jury_judge_ids = []
    @contest.save(validate: false)
    @contest.jury_judge_ids.should eq([])

    @admin.add_role :jury_judge, @contest
    @contest = Contest.find @contest.id
    @contest.jury_judge_ids.should eq([@admin.id])

    @admin.remove_role :jury_judge, @contest
    @contest = Contest.find @contest.id
    @contest.jury_judge_ids.should eq([])

    @contest.jury_judge_ids = [@admin.id]
    @contest.save(validate: false)
    @contest = Contest.find @contest.id
    @contest.jury_judge_ids.should eq([@admin.id])
  end

  context 'validations on update for committee_vice_ids' do
    it 'should be executed' do
      @contest.committee_vice_ids.should eq([])
      @contest.committee_vice_ids = [@admin.id]
      @contest.save.should be_true
      @contest = Contest.find @contest.id
      @contest.committee_vice_ids = []
      @contest.save.should be_false
      @contest.errors.messages[:committee_vice_ids].should be_true
    end

    context 'when committee_vice_ids was not set before' do
      before(:each) do
        @contest.committee_vice_ids.should eq([])
        @contest = Contest.find @contest.id
      end

      it 'should be ignored when set []' do
        @contest.committee_vice_ids = []
        @contest.save.should be_true
      end

      it 'should be ignored when set nil' do
        @contest.committee_vice_ids = nil
        @contest.save.should be_true
      end

      it 'should be ignored when set empty string' do
        @contest.committee_vice_ids = ''
        @contest.save.should be_true
      end

      it 'should be ignored when wasn\'t set' do
        @contest.save.should be_true
      end
    end
  end

  context 'validations on update for committee_head_ids' do
    context 'when committee_head_ids was set before' do
      before(:each) do
        @contest.committee_head_ids.should_not be_empty
        @contest = Contest.find @contest.id
      end

      it 'should be executed when set []' do
        @contest.committee_head_ids = []
        @contest.save.should be_false
        @contest.errors.messages[:committee_head_ids].should be_true
      end

      it 'should executed when set nil' do
        @contest.committee_head_ids = nil
        @contest.save.should be_false
        @contest.errors.messages[:committee_head_ids].should be_true
      end

      it 'should be executed when set empty string' do
        @contest.committee_head_ids = ''
        @contest.save.should be_false
        @contest.errors.messages[:committee_head_ids].should be_true
      end

      it 'should be ignored when is not set' do
        @contest.save.should be_true
      end
    end
  end

  context 'validations on update for jury_head_ids' do
    context 'when jury_head_ids was set before' do
      before(:each) do
        @contest.jury_head_ids.should_not be_empty
        @contest = Contest.find @contest.id
      end

      it 'should be executed when set []' do
        @contest.jury_head_ids = []
        @contest.save.should be_false
        @contest.errors.messages[:jury_head_ids].should be_true
      end

      it 'should executed when set nil' do
        @contest.jury_head_ids = nil
        @contest.save.should be_false
        @contest.errors.messages[:jury_head_ids].should be_true
      end

      it 'should be executed when set empty string' do
        @contest.jury_head_ids = ''
        @contest.save.should be_false
        @contest.errors.messages[:jury_head_ids].should be_true
      end

      it 'should be ignored when is not set' do
        @contest.save.should be_true
      end
    end
  end

  context 'validations on update for jury_judge_ids' do
    it 'should be executed' do
      @contest.jury_judge_ids.should eq([])
      @contest.jury_judge_ids = [@admin.id]
      @contest.save.should be_true
      @contest = Contest.find @contest.id
      @contest.jury_judge_ids = []
      @contest.save.should be_false
      @contest.errors.messages[:jury_judge_ids].should be_true
    end

    context 'when jury_judge_ids was not set before' do
      before(:each) do
        @contest.jury_judge_ids.should eq([])
        @contest = Contest.find @contest.id
      end

      it 'should be ignored when set []' do
        @contest.jury_judge_ids = []
        @contest.save.should be_true
      end

      it 'should be ignored when set nil' do
        @contest.jury_judge_ids = nil
        @contest.save.should be_true
      end

      it 'should be ignored when set empty string' do
        @contest.jury_judge_ids = ''
        @contest.save.should be_true
      end

      it 'should be ignored when wasn\'t set' do
        @contest.save.should be_true
      end
    end
  end

end
