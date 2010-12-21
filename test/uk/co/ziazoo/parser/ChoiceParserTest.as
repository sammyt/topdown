/**
 * Created by IntelliJ IDEA.
 * User: sammy
 * Date: 21/12/2010
 * Time: 10:30
 * To change this template use File | Settings | File Templates.
 */
package uk.co.ziazoo.parser
{
  import org.flexunit.asserts.assertEquals;
  import org.flexunit.asserts.assertFalse;
  import org.flexunit.asserts.assertTrue;

  public class ChoiceParserTest
  {
    private var b:IParserBuilder;

    public function ChoiceParserTest()
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
    public function choiceWithSuccess():void
    {
      var parsers:Array = [
        b.terminal("a"),
        b.terminal("b"),
        b.terminal("c"),
        b.terminal("d")
      ];
      var parser:ChoiceParser = new ChoiceParser(parsers);

      var result:Result = parser.parse("a");

      assertTrue(result.success);
      assertEquals("a", result.instance);
    }

    [Test]
    public function choiceWithFailt():void
    {
      var parsers:Array = [
        b.terminal("a"),
        b.terminal("b"),
        b.terminal("c"),
        b.terminal("d")
      ];
      var parser:ChoiceParser = new ChoiceParser(parsers);

      var result:Result = parser.parse("f");

      assertFalse(result.success);
    }
  }
}
