/**
 * Created by IntelliJ IDEA.
 * User: sammy
 * Date: 19/12/2010
 * Time: 16:13
 * To change this template use File | Settings | File Templates.
 */
package uk.co.ziazoo.parser
{
  import org.flexunit.asserts.assertEquals;
  import org.flexunit.asserts.assertFalse;
  import org.flexunit.asserts.assertNotNull;
  import org.flexunit.asserts.assertNull;
  import org.flexunit.asserts.assertTrue;
  import org.hamcrest.assertThat;
  import org.hamcrest.object.equalTo;

  public class ZeroOrMoreParserTests
  {
    private var b:IParserBuilder;

    public function ZeroOrMoreParserTests()
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
    public function parseWithResult():void
    {
      var hello:IParser = b.whitespace(b.toParser("hello"));
      var p:ZeroOrMoreParser = new ZeroOrMoreParser(hello);

      var result:Result = p.parse("hello hello hello");

      assertNotNull(result);
      assertTrue(result.success);

      var instance:Array = result.instance as Array;
      assertNotNull(instance);
      assertEquals(3, instance.length);
      assertThat(instance, equalTo(["hello", "hello", "hello"]));
    }


    [Test]
    public function parseWithNoResult():void
    {
      var hello:IParser = b.whitespace(b.toParser("hello"));
      var p:ZeroOrMoreParser = new ZeroOrMoreParser(hello);

      var result:Result = p.parse("yo yo yo");

      assertNotNull(result);
      assertTrue(result.success);
      assertFalse(result.producedOutput);
      assertNull(result.instance);
    }
  }
}
