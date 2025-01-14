# frozen_string_literal: true

class Song < ActiveRecord::Base
  belongs_to :artist
  belongs_to :genre
  has_many :notes

  def genre_name=(name)
    self.genre = Genre.find_or_create_by(name: name)
  end

  def genre_name
    try(:genre).try(:name)
  end

  def artist_name=(name)
    self.artist = Artist.find_or_create_by(name: name)
  end

  def artist_name
    try(:artist).try(:name)
  end

  def note_contents=(notes)
    notes.each do |note|
      self.notes.build(content: note) unless note.empty?
    end
  end

  def note_contents
    notes.collect(&:content)
  end
end
