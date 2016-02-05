module ApplicationHelper
  include LetterAvatar::AvatarHelper
  def title(*parts)
    unless parts.empty?
      content_for :title do
        (parts << "知乎").join('-')
      end
    end
  end
end
