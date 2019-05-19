class Machine
  def initialize
    @switch = :off
  end

  def start
    flip_switch(:on)
  end

  def stop
    flip_switch(:off)
  end

  def state
    switch
  end

  private

  attr_accessor :switch

  def flip_switch(desired_state)
    self.switch = desired_state
  end
end

machine = Machine.new
print 'Initial condition... the state is '
p machine.state

print 'Starting machine... The state is now '
machine.start
p machine.state

print 'Stopping machine... The state is now '
machine.stop
p machine.state
