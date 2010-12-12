/**
 * Created by IntelliJ IDEA.
 * User: sammy
 * Date: 04/12/2010
 * Time: 16:20
 * To change this template use File | Settings | File Templates.
 */
package uk.co.ziazoo.parser
{
  public class EitherParser extends AbstractParser
  {
    private var second:IParser;
    private var first:IParser;

    public function EitherParser(first:IParser, second:IParser)
    {
      this.first = first;
      this.second = second;
    }

    override public function parse(parserState:ParserState):Result
    {
      var result:Result = first.parse(parserState);
      if (result.success)
      {
        return new Result(true, result.instance);
      }
      else
      {
        result = second.parse(parserState);

        if (result.success)
        {
          return new Result(true, result.instance);
        }
      }
      // TODO: call fail
      return new Result(false);
    }
  }
}
