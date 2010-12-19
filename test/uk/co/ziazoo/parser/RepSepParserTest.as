/**
 * Created by IntelliJ IDEA.
 * User: sammy
 * Date: 19/12/2010
 * Time: 16:56
 * To change this template use File | Settings | File Templates.
 */
package uk.co.ziazoo.parser
{
  import flash.utils.Dictionary;

  import org.flexunit.asserts.assertNotNull;
  import org.flexunit.asserts.assertTrue;
  import org.hamcrest.assertThat;
  import org.hamcrest.object.equalTo;

  public class RepSepParserTest
  {
    private var b:IParserBuilder;

    public function RepSepParserTest()
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
    public function commaSeparatedChars():void
    {
      var parser:RepSepParser = new RepSepParser(b.terminal("a"), b.terminal(","));
      var result:Result = parser.parse("a,a,a,a");

      assertNotNull(result);
      assertNotNull(result.instance);
      assertTrue(result.success);
      assertThat(result.instance, equalTo(["a", ",", "a", ",", "a", ",", "a"]));
    }

    [Test]
    [Ignore]
    public function commaSepWithBindAction():void
    {
      var action:BindAction = new BindAction();

      var parser:RepSepParser = new RepSepParser(
        action.bind(b.terminal("a"), "value"),
        b.terminal(","));

      var list:Array = [];
      action.action = function(args:Dictionary):Array
      {
        list.push(args.value);
        return list;
      };

      parser.setParseAction(action);
      var result:Result = parser.parse("a,a,a,a");

      assertNotNull(result);
      assertTrue(result.success);
    }
  }
}
