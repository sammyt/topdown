/**
 * Created by IntelliJ IDEA.
 * User: sammy
 * Date: 18/12/2010
 * Time: 14:38
 * To change this template use File | Settings | File Templates.
 */
package uk.co.ziazoo.parser.numeric
{
  public class Operation
  {
    private var op:Object;
    private var left:Number;
    private var right:Number;

    public function Operation(op:Object, left:Number, right:Number)
    {
      this.op = op;
      this.left = left;
      this.right = right;
    }

    public function execute():Object
    {
      switch (op)
      {
        case "*":
          return left * right;
        case "+":
          return left + right;
        case "-":
          return left - right;
        case "/":
          return left / right;
      }

      return null;
    }
  }
}
