# frozen_string_literal: true
# This migration comes from decidim_meetings (originally 20210506180226)

class MergeMeetingsMinutesIntoMeetingsTable < ActiveRecord::Migration[6.0]
  class Minutes < ApplicationRecord
    self.table_name = "decidim_meetings_minutes"

    belongs_to :meeting, foreign_key: "decidim_meeting_id", class_name: "Meeting"
  end

  class Meeting < ApplicationRecord
    self.table_name = "decidim_meetings_meetings"
  end

  def up
    change_table :decidim_meetings_meetings, bulk: true
    add_column :decidim_meetings_meetings, :minutes_visible, :boolean, default: false, null: false

    Minutes.find_each do |minutes|
      minutes.meeting.update!(
        minutes_description: minutes.description,
        video_url: minutes.video_url,
        audio_url: minutes.audio_url,
        minutes_visible: minutes.visible
      )
    end
  end

  def down
    Meeting.find_each do |meeting|
      next if meeting.video_url.blank? && meeting.audio_url.blank?

      Minutes.find_or_create_by!(
        decidim_meeting_id: meeting.id,
        description: meeting.minutes_description,
        video_url: meeting.video_url,
        audio_url: meeting.audio_url,
        visible: meeting.minutes_visible
      )
    end

    change_table :decidim_meetings_meetings, bulk: true
    remove_column :decidim_meetings_meetings, :minutes_visible
  end
end
