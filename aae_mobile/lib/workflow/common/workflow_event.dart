/// An event to be used in a [Workflow].
class WorkflowEvent {
  /// The name of this event.
  ///
  /// In the state machine, events are keyed by name -- two events with the
  /// same name but different data would both be fair game to process in the
  /// same event handler. Use guard functions if you need to handle or not
  /// handle based on the data field.
  final String name;

  /// Optional data to attach to this event.
  ///
  /// Handlers are responsible for type checking this field.
  dynamic data;

  WorkflowEvent(this.name, {this.data});

  /// Defines two events to be equal if they share the same name.
  @override
  bool operator ==(o) => o is WorkflowEvent && o.name == name;

  /// Defines the event's hash code to be the hash code of its name.
  ///
  /// Since data is non-final and optional, it should be possible to change the
  /// event's data without changing its hash code. This is important because
  /// the hash code determines what event handlers will handle an event. In this
  /// implementation, an event handler will handle all events with the same
  /// name even if they have different data.
  @override
  int get hashCode => name.hashCode;

  @override
  String toString() => 'WorkflowEvent {\n name=$name,\n data=$data,\n}';
}
