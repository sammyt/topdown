/**
 * Created by IntelliJ IDEA.
 * User: sammy
 * Date: 04/12/2010
 * Time: 15:57
 * To change this template use File | Settings | File Templates.
 */
package ziazoo.combinators
{
  public interface IParser
  {
    function parse(parserState:ParserState):IResult;

    function onAction(factory:Function):void;
  }
}
