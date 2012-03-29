require 'test_helper'

class DefinitionTest < MiniTest::Spec
  describe "generic API" do
    before do
      @def = Representable::Definition.new(:songs)
    end
    
    describe "DCI" do
      it "responds to #representer_module" do
        assert_equal nil, Representable::Definition.new(:song).representer_module
        assert_equal Hash, Representable::Definition.new(:song, :extend => Hash).representer_module
      end
    end
    
    describe "#typed?" do
      it "is false per default" do
        assert ! @def.typed?
      end
      
      it "is true when :class is present" do
        assert Representable::Definition.new(:songs, :class => Hash).typed?
      end
      
      it "is true when :extend is present, only" do
        assert Representable::Definition.new(:songs, :extend => Hash).typed?
      end
    end
    
    it "responds to #getter and returns string" do
      assert_equal "songs", @def.getter
    end
    
    it "responds to #name" do
      assert_equal "songs", @def.name 
    end
    
    it "responds to #setter" do
      assert_equal :"songs=", @def.setter
    end
    
    it "responds to #sought_type" do
      assert_equal nil, @def.sought_type
    end
  end
  
    
  describe ":collection => true" do
    before do
      @def = Representable::Definition.new(:songs, :collection => true, :tag => :song)
    end
    
    it "responds to #array?" do
      assert @def.array?
    end
    
    it "responds to #sought_type" do
      assert_equal nil, @def.sought_type
    end
    
    it "responds to #default" do
      assert_equal [], @def.default
    end
  end
  
  describe ":class => Item" do
    before do
      @def = Representable::Definition.new(:songs, :class => Hash)
    end
    
    it "responds to #sought_type" do
      assert_equal Hash, @def.sought_type
    end
  end
  
  describe ":default => value" do
    it "responds to #default" do
      @def = Representable::Definition.new(:song)
      assert_equal nil, @def.default
    end
    
    it "accepts a default value" do
      @def = Representable::Definition.new(:song, :default => "Atheist Peace")
      assert_equal "Atheist Peace", @def.default
    end
  end
  
  describe ":hash => true" do
    before do
      @def = Representable::Definition.new(:songs, :hash => true)
    end
    
    it "responds to #hash?" do
      assert @def.hash?
    end
  end

  describe ":include_nil => true" do
    it "responds to #include_nil" do
      @def = Representable::Definition.new(:song)
      assert_equal nil, @def.include_nil
    end

    it "accepts a value for #include_nil" do
      @def = Representable::Definition.new(:song, :include_nil => true)
      assert_equal true, @def.include_nil
    end
  end
end
