class String
  def just_latin?
    !!self.match(/^[a-zA-Z0-9_&,\."'\-+ ]*$/i)
  end
end