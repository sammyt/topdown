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

  import uk.co.ziazoo.parser.numeric.Operation;

  public class ParserTests
  {
    public function ParserTests()
    {
    }

    [Test]
    public function parserNumericExpr():void
    {
      var b:IParserBuilder = new ParserBuilder();

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
      var b:IParserBuilder = new ParserBuilder();
      var p:IParser = b.sequence("hello", "all", "you", "chaps");
      var r:Object = p.parse(new ParserState("hello all you chaps"));
      assertNotNull(r);
      assertTrue(r.instance is Array);
      assertEquals(4, r.instance.length);
    }

    [Test]
    public function createBasicAST():void
    {
      var b:IParserBuilder = new ParserBuilder();
      var e:Extractor = new Extractor();

      var num:IParser = b.range("0", "9");

      var plus:IParser =
        b.sequence(
          e.bind(num, "left"),
          "+",
          e.bind(num, "right"))
          .extractor(e);

      e.action = function(args:Object):Object
      {
        return new Operation("+", args.left, args.right);
      };

      var r:Result = plus.parse(new ParserState("1 + 5"));

      assertNotNull(r);
      assertNotNull(r.instance);
      assertTrue(r.instance is Operation);

      assertEquals(6, r.instance.execute());
    }


    [Test]
    [Ignore]
    public function createFullNumericAST():void
    {
      var b:IParserBuilder = new ParserBuilder();

      var number:IParser = b.range("0", "9");
      var p:Extractor = new Extractor();
      var s:Extractor = new Extractor();


      var value:IParser = b.either(
        b.oneOrMore(number),
        b.sequence(
          "(",
          b.future("expr"),
          ")")
        );

      var product:IParser = b.sequence(
        p.bind(value, "left"),
        b.zeroOrMore(
          b.sequence(
            p.bind(b.either("*", "/"), "op"),
            p.bind(value, "right")
            )
          )
        );

      var sum:IParser = b.sequence(
        s.bind(product, "left"),
        b.zeroOrMore(
          b.sequence(
            s.bind(b.either("+", "-"), "op"),
            s.bind(product, "right")
            )
          )
        );

      s.action = p.action = function(args:Object):Object
      {
        return new Operation(args.op, args.left, args.right).execute();
      };


      var expr:IParser = b.satisfyFuture("expr", sum);
      product.extractor(p);
      sum.extractor(s);

      var r1:Object = expr.parse(new ParserState("5*2"));

      var r2:Object = expr.parse(new ParserState("5*2-7"));

      assertNotNull(r1);
      assertNotNull(r1.instance);
      assertEquals(10, r1.instance);


      assertNotNull(r2);
      assertNotNull(r2.instance);
      assertEquals(3, r2.instance);
    }
  }
}