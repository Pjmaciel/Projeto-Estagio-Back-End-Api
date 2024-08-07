class UserFactoryHelper
  @valid_cpfs = [
    '75092503076',
    '47411058068',
    '40629410070',
    '22818478022',
    '82446536042',
    '71991314027',
    '25481154021',
    '76127697000'
  ]

  def self.next_cpf
    @valid_cpfs.pop || raise("No more valid CPFs available")
  end

  def self.reset_cpfs
    @valid_cpfs = [
      '75092503076',
      '47411058068',
      '40629410070',
      '22818478022',
      '82446536042',
      '71991314027',
      '25481154021',
      '76127697000'
    ]
  end
end