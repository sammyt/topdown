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

  public class ParserTests
  {
    public function ParserTests()
    {
    }

    [Test]
    public function parserNumericExpr():void
    {
      var b:ParserBuilder = new ParserBuilder();

      var value:IParser = b.either(
        b.oneOrMore(b.range("0", "9")),
        b.sequence(
          "(",
          b.future("expr"),
          ")")
        );

      var product:IParser = b.sequence(
        value,
        b.zeroOrMore(
          b.sequence(
            b.either("*", "/"),
            value
            )
          )
        );

      var sum:IParser = b.sequence(
        product,
        b.zeroOrMore(
          b.sequence(
            b.either("+", "-"),
            product
            )
          )
        );

      var expr:IParser = b.satisfyFuture("expr", sum);
      var input:String = "1+2+3-4+1+2*3-(4/1+2*3)-4*1+2*3-4";
      var ps:ParserState = new ParserState(input);
      var result:Object = expr.parse(ps);

      assertNotNull(result);
      assertEquals(ps.index, input.length);
    }

    [Test]
    public function helloWorld():void
    {
      var b:ParserBuilder = new ParserBuilder();
      var p:IParser = b.sequence("hello", "all", "you", "chaps");
      var r:Object = p.parse(new ParserState("hello all you chaps"));
      assertNotNull(r);
      assertTrue(r.instance is Array);
      assertEquals(4, r.instance.length);
    }

    [Test]
    public function createBasicAST():void
    {
      var b:ParserBuilder = new ParserBuilder();
      var e:Extractor = new Extractor();

      var num:IParser = b.range("0", "9");

      var plus:IParser =
        b.sequence(
          e.bind(num, "left"),
          "+",
          e.bind(num, "right"));

      plus.extractor = e;

      e.action = function(args:Object):Object
      {
        return new PlusOperation(args.left, args.right);
      };

      var r:Result = plus.parse(new ParserState("1 + 5"));

      assertNotNull(r);
      assertNotNull(r.instance);
      assertTrue(r.instance is PlusOperation);

      assertEquals(6, r.instance.execute());
    }
  }
}

class PlusOperation
{
  private var left:Number;
  private var right:Number;

  public function PlusOperation(left:Number, right:Number)
  {
    this.left = left;
    this.right = right;
  }

  public function execute():Number
  {
    return left + right;
  }
}


