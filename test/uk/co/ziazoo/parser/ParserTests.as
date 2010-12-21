/**
 * Created by IntelliJ IDEA.
 * User: sammy
 * Date: 11/12/2010
 * Time: 12:29
 * To change this template use File | Settings | File Templates.
 */
package uk.co.ziazoo.parser
{
  import org.flexunit.asserts.assertEquals;
  import org.flexunit.asserts.assertNotNull;
  import org.flexunit.asserts.assertTrue;
  import org.hamcrest.assertThat;
  import org.hamcrest.object.equalTo;

  import uk.co.ziazoo.parser.numeric.Operation;

  public class ParserTests
  {
    public function ParserTests()
    {
    }


    [Test]
    public function helloWorld():void
    {
      var b:IParserBuilder = new ParserBuilder();
      var p:IParser = b.sequence("hello", "all", "you", "chaps");
      var r:Result = p.parse("hello all you chaps");
      assertNotNull(r);
      assertTrue(r.instance is Array);
      assertEquals(4, r.instance.length);
    }

    [Test]
    public function createBasicAST():void
    {
      var b:IParserBuilder = new MemoTableBuilder(new ParserBuilder());
      var action:BindAction = new BindAction();

      var num:IParser = b.range("0", "9");

      var plus:IParser = b.sequence(action.bind(num, "left"), "+", action.bind(num, "right"));
      plus.setParseAction(action);


      action.action = function(args:Object):Object
      {
        return new Operation("+", args.left, args.right);
      };

      var r:Result = plus.parse("1 + 5");

      assertNotNull(r);
      assertNotNull(r.instance);
      assertTrue(r.instance is Operation);

      assertEquals(6, r.instance.execute());
    }

    [Test]
    public function basicSExp():void
    {
      var b:IParserBuilder = new MemoTableBuilder(new ParserBuilder());

      var sexp:IParser = b.chose("a", "1", b.sequence("(", b.zeroOrMore(b.future("sexp")), ")"));
      b.satisfyFuture("sexp", sexp);

      var result:Result = sexp.parse("(a(1a1a))");

      assertNotNull(result);
      assertTrue(result.success);
      assertThat(result.instance, equalTo(["(",["a", ["(",["1","a","1","a"],")"]],")"]));
    }
  }
}