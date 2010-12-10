/**
 * Created by IntelliJ IDEA.
 * User: sammy
 * Date: 10/12/2010
 * Time: 19:28
 * To change this template use File | Settings | File Templates.
 */
package ziazoo.combinators
{
  public class AbstractParser implements IParser
  {
    private var _onAction:Function;

    public function AbstractParser()
    {
    }

    public function parse(parserState:ParserState):IResult
    {
      return null;
    }

    public function onAction(factory:Function):void
    {
      _onAction = factory;
    }
  }
}
