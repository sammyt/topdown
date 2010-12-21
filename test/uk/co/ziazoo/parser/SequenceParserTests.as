/**
 * Created by IntelliJ IDEA.
 * User: sammy
 * Date: 19/12/2010
 * Time: 14:55
 * To change this template use File | Settings | File Templates.
 */
package uk.co.ziazoo.parser
{
  import flash.utils.Dictionary;

  import org.flexunit.asserts.assertEquals;
  import org.flexunit.asserts.assertFalse;
  import org.flexunit.asserts.assertNotNull;
  import org.flexunit.asserts.assertNull;
  import org.flexunit.asserts.assertTrue;
  import org.hamcrest.assertThat;
  import org.hamcrest.object.equalTo;

  public class SequenceParserTests
  {
    private var b:IParserBuilder;

    public function SequenceParserTests()
    {
    }

    [Before]
    public function setUp():void
    {
      b = new ParserBuilder();
    }

    [After]
    public function tearDown():void
    {
      b = null;
    }

    [Test]
    public function parseBasicSequence():void
    {
      var parsers:Array = [
        b.whitespace(b.terminal("one")),
        b.whitespace(b.terminal("fine")),
        b.whitespace(b.terminal("day"))
      ];
      var p:SequenceParser = new SequenceParser(parsers);

      var result:Result = p.parse("one fine day");

      assertNotNull(result);
      assertTrue(result.success);

      var instance:Array = result.instance as Array;
      assertNotNull(instance);
      assertEquals(3, instance.length);
      assertThat(instance, equalTo(["one", "fine", "day"]));
    }

    [Test]
    public function parseNestedSequence():void
    {
      var verys:IParser = b.sequence("very", "very");

      var parsers:Array = [
        b.whitespace(b.terminal("one")),
        verys,
        b.whitespace(b.terminal("fine")),
        b.whitespace(b.terminal("day"))
      ];
      var p:SequenceParser = new SequenceParser(parsers);

      var result:Result = p.parse("one very very fine day");

      assertNotNull(result);
      assertTrue(result.success);

      var instance:Array = result.instance as Array;
      assertNotNull(instance);
      assertThat(instance, equalTo(["one",["very", "very"] , "fine", "day"]));
    }

    [Test]
    public function parseWithCustomAction():void
    {
      var action:BindAction = new BindAction();
      var p:SequenceParser = b.sequence("one", action.bind(b.terminal("fine"), "value"), "day") as SequenceParser;

      action.action = function(args:Dictionary):String
      {
        return args.value;
      };

      p.setParseAction(action);

      var result:Result = p.parse("one fine day");

      assertNotNull(result);
      assertTrue(result.success);

      var instance:Object = result.instance;
      assertNotNull(instance);
      assertThat(instance, equalTo("fine"));
    }

    [Test]
    public function whenChildDoesNotProduceResultsSequence():void
    {
      var verys:IParser = b.zeroOrMore(b.whitespace("very"));

      var parsers:Array = [
        b.whitespace(b.terminal("one")),
        verys,
        b.whitespace(b.terminal("fine")),
        b.whitespace(b.terminal("day"))
      ];
      var p:SequenceParser = new SequenceParser(parsers);

      var r1:Result = p.parse("one very very fine day");

      assertNotNull(r1);
      assertTrue(r1.success);

      var instance1:Array = r1.instance as Array;
      assertNotNull(instance1);
      assertThat(instance1, equalTo(["one",["very", "very"] , "fine", "day"]));

      var r2:Result = p.parse("one fine day");

      assertNotNull(r2);
      assertTrue(r2.success);

      var instance2:Array = r2.instance as Array;
      assertNotNull(instance2);
      assertThat(instance2, equalTo(["one", "fine", "day"]));
    }

    [Test]
    public function parseWithBadInput():void
    {
      var parsers:Array = [
        b.whitespace(b.terminal("one")),
        b.whitespace(b.terminal("fine")),
        b.whitespace(b.terminal("day"))
      ];
      var p:SequenceParser = new SequenceParser(parsers);

      var result:Result = p.parse("one grumpy day");

      assertNotNull(result);
      assertFalse(result.success);
      assertNull(result.instance);
      assertEquals(1, result.failures.length);
    }

    [Test]
    public function seqWithSeqInside():void
    {
      var list:IParser = b.sequence("(", b.zeroOrMore(b.future("value")), ")");
      var value:IParser = b.chose(list, "a");
      b.satisfyFuture("value", value);

      var result:Result = list.parse("(a(a))");

      assertNotNull(result);
      assertTrue(result.success);
      assertThat(result.instance, equalTo(["(",["a",["(","a",")"]],")"]));
    }
  }
}
