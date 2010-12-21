/**
 * Created by IntelliJ IDEA.
 * User: sammy
 * Date: 21/12/2010
 * Time: 12:34
 * To change this template use File | Settings | File Templates.
 */
package uk.co.ziazoo.parser
{
  import org.flexunit.asserts.assertEquals;
  import org.flexunit.asserts.assertNotNull;
  import org.flexunit.asserts.assertTrue;
  import org.hamcrest.assertThat;
  import org.hamcrest.object.equalTo;

  public class FutureParserTest
  {
    private var b:IParserBuilder;

    public function FutureParserTest()
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
    public function usingBasicTerminal():void
    {
      var f:FutureParser = new FutureParser();
      f.target = b.terminal("a");

      var result:Result = f.parse("a");

      assertNotNull(result);
      assertEquals("a", result.instance);
    }

    [Test]
    public function usingBasicTerminalFromBuilder():void
    {
      var p:IParser = b.future("term");

      b.satisfyFuture("term", b.terminal("a"));

      var result:Result = p.parse("a");

      assertNotNull(result);
      assertEquals("a", result.instance);
    }

    [Test]
    public function usingSequenceFromBuilder():void
    {
      var list:IParser = b.sequence("[", b.future("item"), "]");

      b.satisfyFuture("item", b.terminal("a"));

      var result:Result = list.parse("[a]");

      assertNotNull(result);
      assertTrue(result.success);
      assertThat(result.instance, equalTo(["[", "a", "]"]));
    }

    [Test]
    public function usingMemoTable():void
    {
      var m:IParserBuilder = new MemoTableBuilder(b);
      var list:IParser = m.sequence("[", m.future("item"), "]");

      m.satisfyFuture("item", m.terminal("a"));

      var result:Result = list.parse("[a]");

      assertNotNull(result);
      assertTrue(result.success);
      assertThat(result.instance, equalTo(["[", "a", "]"]));
    }
  }
}
