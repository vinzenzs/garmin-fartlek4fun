

class Fartlek {
    public var id;
    public var name;
    public var fast;
    public var slow;
    public var repeat;

    public function initialize(id, name, fast, slow, repeat) {
        self.id = id;
        self.name = name;
        self.fast = fast;
        self.slow = slow;
        self.repeat = repeat;
    }

    function hashCode() {
        return id;
    }
}