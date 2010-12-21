/**
 * Created by IntelliJ IDEA.
 * User: sammy
 * Date: 21/12/2010
 * Time: 10:19
 * To change this template use File | Settings | File Templates.
 */
package uk.co.ziazoo.parser
{
  import org.flexunit.asserts.assertEquals;
  import org.flexunit.asserts.assertNotNull;
  import org.flexunit.asserts.assertTrue;
  import org.hamcrest.assertThat;
  import org.hamcrest.object.equalTo;

  public class OneOrMoreParserTest
  {
    private var b:IParserBuilder;

    public function OneOrMoreParserTest()
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
      var p:OneOrMoreParser = new OneOrMoreParser(hello);

      var result:Result = p.parse("hello hello hello");

      assertNotNull(result);
      assertTrue(result.success);

      var instance:Object = result.instance;
      assertNotNull(instance);
      assertEquals(3, instance.length);
      assertThat(instance, equalTo(["hello", "hello", "hello"]));
    }
  }
}
